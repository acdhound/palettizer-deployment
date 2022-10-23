# palettizer-deployment

Requirements:
* Python 3
* PIP
* AWS CLI with configured credentials
* AWS CDK

Build:
```bash
pip install -r requirements.txt
```

Deploy:
```bash
cdk bootstrap
cdk deploy --require-approval never
```

Start session:
```bash
aws ssm start-session --target i-xxxxxxx
```

Destroy:
```bash
cdk destroy
```
