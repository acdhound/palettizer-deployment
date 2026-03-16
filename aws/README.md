# palettizer-deployment

Requirements:
* Python 3.13+, PIP, virtualenv
* nodejs, NPM
* AWS CLI with configured credentials
* AWS CDK (version 2.1107.0 or higher)

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

Deploy (main instance):
```bash
cdk bootstrap
cdk deploy palettizer-bot --require-approval never \
--parameters botToken=<Telegram Bot token> \
--parameters pyVersion=<Python version, e. g. 3.13>
```

Deploy (dev):
```bash
cdk bootstrap
cdk deploy palettizer-bot-dev --require-approval never \
--parameters botToken=<Telegram Bot token> \
--parameters pyVersion=<Python version> \
--parameters gitBranch=<Git Branch to Chekout (Optional)>
```

Start session:
```bash
aws ssm start-session --target i-xxxxxxx
```

Destroy main instance:
```bash
cdk destroy palettizer-bot
```

Destroy dev:
```bash
cdk destroy palettizer-bot-dev
```