# palettizer-deployment

Requirements:
* Python 3, PIP, virtualenv
* nodejs, NPM
* AWS CLI with configured credentials
* AWS CDK (version 2.113.0 or higher)

Build:
* Create and activate virtual env
```bash
# Unix
pip install virtualenv
virtualenv venv
source ./venv/bin/activate   # ./venv/Scripts/activate if you use Git Bash on Windows
```
```cmd
REM Windows
pip install virtualenv
virtualenv venv
venv\Scripts\activate.bat
```
* Install dependencies
```bash
pip install -r requirements.txt
```

Deploy:
```bash
cdk bootstrap
cdk deploy --require-approval never --parameters botToken=<Telegram Bot token>
```

Start session:
```bash
aws ssm start-session --target i-xxxxxxx
```

Destroy:
```bash
cdk destroy
```
