
use lambda_layer::environment::{get_env_variable};

use lambda_http::{
    handler,
    lambda_runtime::{self, Context, Error},
    IntoResponse, Request, RequestExt, Response,
};
use aws_sdk_dynamodb::{Client};
use aws_sdk_dynamodb::model::AttributeValue;

static USERS_TABLE_NAME: &str = "USERS";

#[tokio::main]
async fn main() -> Result<(), Error> {
    lambda_runtime::run(handler(func)).await?;
    Ok(())
}

async fn func(event: Request, _: Context) -> Result<impl IntoResponse, Error> {

    let query_string = event.query_string_parameters();

    let shared_config = aws_config::load_from_env().await;
    let client = Client::new(&shared_config);
    
    let table_name = get_env_variable(USERS_TABLE_NAME);
    let username = match query_string.get("username") {
        Some(value) => String::from(value),
        _ => panic!("No username provided!")
    };
    let req = client
        .get_item()
        .table_name(table_name)
        .key("username", AttributeValue::S(username));
    let response = match req.send().await {
        Ok(r) => r,
        Err(e) => panic!("Could not find the user.")
    };

    return Ok(Response::builder()
        .status(200)
        .body(response.item));
}