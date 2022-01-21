use lambda_http::{
    handler,
    lambda_runtime::{self, Context, Error},
    IntoResponse, Request, RequestExt, Response,
};

#[tokio::main]
async fn main() -> Result<(), Error> {
    println!("Hello!");
    lambda_runtime::run(handler(func)).await?;
    Ok(())
}

async fn func(event: Request, _: Context) -> Result<impl IntoResponse, Error> {
    println!("{:?}", event);
    Ok(match event.query_string_parameters().get("username") {
        Some(username) => format!("Hello, {}!", username).into_response(),
        _ => Response::builder()
            .status(400)
            .body("Empty first name".into())
            .expect("failed to render response"),
    })
}