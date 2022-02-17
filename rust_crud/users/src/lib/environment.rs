use std;

pub fn get_env_variable(var_name: &str) -> String {
    let env_variable = match std::env::var_os(var_name) {
        Some(v) => v.into_string().unwrap(),
        None => panic!("{} is not set.", var_name)
    };

    return env_variable;
}