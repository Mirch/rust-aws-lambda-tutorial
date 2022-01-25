import os

function_parent_folder = "./lambda_functions"
build_target = "x86_64-unknown-linux-musl"
output_file_name = "bootstrap"


print("[BUILD] Starting Rust functions building process...")
function_folders = [name for name in os.listdir(function_parent_folder)]

for function_folder in function_folders:
    print(f"[BUILD] Building {function_folder} function...")
    commands = []
    
    # move to function folder
    commands.append(f"cd {function_parent_folder}/{function_folder}")
    # build the project
    commands.append(f"cargo build --release --target {build_target}")
    # create the bootstrap file
    commands.append(f"cp ./target/{build_target}/release/{function_folder} {output_file_name}")
    
    os.system("; ".join(commands))
    
    