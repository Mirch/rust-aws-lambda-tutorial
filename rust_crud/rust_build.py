import os

project_folder = "./users"
project_source_folder = f"{project_folder}/src/bin"
build_target = "x86_64-unknown-linux-musl"
output_file_name = "bootstrap"


commands = []
print("[BUILD] Installing musl-tools...")
commands.append("sudo apt install musl-tools")
print("[BUILD] Building the Rust project...")
# move to project folder
commands.append(f"cd {project_source_folder}")
# build the project
commands.append(f"cargo build --release --target {build_target}")
print(commands)
os.system("; ".join(commands))
commands.clear()

print("[BUILD] Starting Rust functions building process...")
function_folders = [name for name in os.listdir(project_source_folder)]
for function_folder in function_folders:
    print(f"[BUILD] Creating {function_folder} output file...")
    
    # create the bootstrap file
    commands.append(f"cp {project_folder}/target/{build_target}/release/{function_folder} bin/{function_folder}/{output_file_name}")
    
    os.system("; ".join(commands))
    commands.clear()
    
    
