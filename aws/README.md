# palettizer-deployment

Requirements:
* Python 3, PIP, virtualenv
* nodejs, NPM
* AWS CLI with configured credentials
* AWS CDK

Build:
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
