import os
import shutil
import sys
import subprocess

def to_git(remote_repository: str, email: str, username: str):
    if not remote_repository:
        raise Exception("remote_repository must be set")
        
    readme = "README.md"
    if os.path.exists(readme):
        os.remove(readme)
    with open(readme, "w") as f:
        f.write("# ISUCON 11 予選")

    add_statement = ["git", "add", readme]  + list(sys.argv[1:])
    statements = (
        ["git", "config", "--global", "user.email", email],
        ["git", "config", "--global", "user.name", username],
        ["git", "init"],
        add_statement,
        ["git", "commit", "-m", "'initial state'"],
        ["git", "branch", "-M", "main"],
        ["git", "remote", "add", "origin", remote_repository],
        ["git", "push", "-u", "origin", "main"]
    )
    for statement in statements:
        subprocess.run(statement)


def generate_ssh_key_and_conf():
    current_dir = os.getcwd()
    home = os.getenv("HOME")
    ssh_dir = home + "/.ssh"

    if not os.path.exists(ssh_dir):
        os.mkdir(ssh_dir)
    os.chdir(ssh_dir)

    subprocess.call(["ssh-keygen", "-t", "rsa", "-b", "4096", "-f", "id_rsa"])
    with open("config", "w") as f:
        cfg = """\
Host github
    HostName github.com
    IdentityFile ~/.ssh/id_rsa
    User git
"""
        f.write(cfg)

    print("以下をGithubアカウントの公開鍵としてセットしてください")
    subprocess.call(["cat", "id_rsa.pub"])
    os.chdir(current_dir)

def clean_up():
    if os.path.exists(".git"):
        shutil.rmtree(".git/") 
    ssh_dir = os.getenv("HOME") + "/.ssh/"
    if os.path.exists(ssh_dir):
        shutil.rmtree(ssh_dir)


if __name__ == "__main__":
    while True:
        generate_ssh_key_and_conf()
        print("Pushするレポジトリ、アカウントのemail、ユーザー名を入力してください。ex) git@github.com:team-kinoko/test.git")
        repository = input("Repository >> ")
        email = input("Email >> ")
        username = input("Username >> ")
        try:
            to_git(repository, email, username)
        except Exception as err:
            clean_up()
            print("何らかのエラーが発生しました。", err)
            continue
        break