use wasm_bindgen::prelude::*;
use web_sys::{console, window, HtmlInputElement, HtmlButtonElement};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Clone)]
pub struct Message {
    id: u32,
    content: String,
    timestamp: u64,
    sender: String,
}

#[derive(Serialize, Deserialize)]
pub struct ChatResponse {
    messages: Vec<Message>,
}

static mut MESSAGE_ID_COUNTER: u32 = 0;

#[wasm_bindgen]
pub struct ChatApp {
    messages: Vec<Message>,
    current_user: String,
}

#[wasm_bindgen]
impl ChatApp {
    #[wasm_bindgen(constructor)]
    pub fn new(username: String) -> ChatApp {
        console_error_panic_hook::set_once();
        ChatApp {
            messages: Vec::new(),
            current_user: username,
        }
    }

    #[wasm_bindgen]
    pub fn send_message(&mut self, content: String) -> Result<(), JsValue> {
        if content.trim().is_empty() {
            return Ok(());
        }

        unsafe {
            MESSAGE_ID_COUNTER += 1;
        }

        let message = Message {
            id: unsafe { MESSAGE_ID_COUNTER },
            content: content.trim().to_string(),
            timestamp: js_sys::Date::now() as u64,
            sender: self.current_user.clone(),
        };

        self.messages.push(message.clone());
        self.send_to_server(&message)?;
        self.render_messages()?;
        Ok(())
    }

    #[wasm_bindgen]
    pub fn poll_messages(&mut self) -> Result<(), JsValue> {
        let window = window().unwrap();
        let location = window.location().href().unwrap();
        let base_url = if location.contains("localhost") || location.contains("127.0.0.1") {
            "http://localhost:3000"
        } else {
            ""
        };

        let url = format!("{}/api/messages", base_url);

        let promise = window.fetch_with_str(&url);
        let chat_app_ptr = self as *mut ChatApp;

        let closure = Closure::wrap(Box::new(move |response: JsValue| {
            let response: web_sys::Response = response.into();
            let text_promise = response.text().unwrap();
            
            let closure2 = Closure::wrap(Box::new(move |text: JsValue| {
                let text_str = text.as_string().unwrap_or_default();
                if let Ok(chat_response) = serde_json::from_str::<ChatResponse>(&text_str) {
                    unsafe {
                        if let Some(chat_app) = chat_app_ptr.as_mut() {
                            chat_app.messages = chat_response.messages;
                            let _ = chat_app.render_messages();
                        }
                    }
                }
            }) as Box<dyn FnMut(JsValue)>);

            let _ = text_promise.then(&closure2);
            closure2.forget();
        }) as Box<dyn FnMut(JsValue)>);

        let _ = promise.then(&closure);
        closure.forget();
        Ok(())
    }

    fn send_to_server(&self, message: &Message) -> Result<(), JsValue> {
        let window = window().unwrap();
        let location = window.location().href().unwrap();
        let base_url = if location.contains("localhost") || location.contains("127.0.0.1") {
            "http://localhost:3000"
        } else {
            ""
        };

        let url = format!("{}/api/messages", base_url);
        let json_data = serde_json::to_string(message).unwrap();

        let mut opts = web_sys::RequestInit::new();
        opts.set_method("POST");
        opts.set_body(&JsValue::from_str(&json_data));

        let headers = web_sys::Headers::new().unwrap();
        headers.set("Content-Type", "application/json").unwrap();
        opts.set_headers(&headers);

        let request = web_sys::Request::new_with_str_and_init(&url, &opts).unwrap();
        let _promise = window.fetch_with_request(&request);
        Ok(())
    }

    fn render_messages(&self) -> Result<(), JsValue> {
        let document = window().unwrap().document().unwrap();
        let messages_container = document.get_element_by_id("messages").unwrap();
        
        let mut html = String::new();
        for message in &self.messages {
            let is_own = message.sender == self.current_user;
            let class = if is_own { "message own" } else { "message other" };
            html.push_str(&format!(
                r#"<div class="{}">
                    <div class="sender">{}</div>
                    <div class="content">{}</div>
                    <div class="timestamp">{}</div>
                </div>"#,
                class,
                message.sender,
                message.content,
                format_timestamp(message.timestamp)
            ));
        }
        
        messages_container.set_inner_html(&html);
        
        // Scroll to bottom
        let messages_element: web_sys::HtmlElement = messages_container.dyn_into().unwrap();
        messages_element.set_scroll_top(messages_element.scroll_height());
        
        Ok(())
    }

    #[wasm_bindgen]
    pub fn setup_ui(&self) -> Result<(), JsValue> {
        let document = window().unwrap().document().unwrap();
        
        // Setup send button click handler
        if let Some(send_button) = document.get_element_by_id("send-button") {
            let send_button: HtmlButtonElement = send_button.dyn_into().unwrap();
            let chat_app_ptr = self as *const ChatApp as *mut ChatApp;
            
            let closure = Closure::wrap(Box::new(move |_event: web_sys::Event| {
                let document = window().unwrap().document().unwrap();
                if let Some(input) = document.get_element_by_id("message-input") {
                    let input: HtmlInputElement = input.dyn_into().unwrap();
                    let message = input.value();
                    input.set_value("");
                    
                    unsafe {
                        if let Some(chat_app) = chat_app_ptr.as_mut() {
                            let _ = chat_app.send_message(message);
                        }
                    }
                }
            }) as Box<dyn FnMut(web_sys::Event)>);
            
            send_button.set_onclick(Some(closure.as_ref().unchecked_ref()));
            closure.forget();
        }

        // Setup enter key handler for input
        if let Some(input) = document.get_element_by_id("message-input") {
            let input: HtmlInputElement = input.dyn_into().unwrap();
            let chat_app_ptr = self as *const ChatApp as *mut ChatApp;
            
            let closure = Closure::wrap(Box::new(move |event: web_sys::KeyboardEvent| {
                if event.key() == "Enter" {
                    let document = window().unwrap().document().unwrap();
                    if let Some(input) = document.get_element_by_id("message-input") {
                        let input: HtmlInputElement = input.dyn_into().unwrap();
                        let message = input.value();
                        input.set_value("");
                        
                        unsafe {
                            if let Some(chat_app) = chat_app_ptr.as_mut() {
                                let _ = chat_app.send_message(message);
                            }
                        }
                    }
                }
            }) as Box<dyn FnMut(web_sys::KeyboardEvent)>);
            
            input.set_onkeypress(Some(closure.as_ref().unchecked_ref()));
            closure.forget();
        }

        Ok(())
    }

    #[wasm_bindgen]
    pub fn start_polling(&self) {
        let chat_app_ptr = self as *const ChatApp as *mut ChatApp;
        
        let closure = Closure::wrap(Box::new(move || {
            unsafe {
                if let Some(chat_app) = chat_app_ptr.as_mut() {
                    let _ = chat_app.poll_messages();
                }
            }
        }) as Box<dyn FnMut()>);
        
        let window = window().unwrap();
        window.set_interval_with_callback_and_timeout_and_arguments_0(
            closure.as_ref().unchecked_ref(),
            1000,
        ).unwrap();
        
        closure.forget();
    }
}

fn format_timestamp(timestamp: u64) -> String {
    let date = js_sys::Date::new_0();
    date.set_time(timestamp as f64);
    let hours = date.get_hours();
    let minutes = date.get_minutes();
    format!("{:02}:{:02}", hours, minutes)
}

#[wasm_bindgen(start)]
pub fn main() {
    console::log_1(&"Chat WebAssembly module loaded".into());
}