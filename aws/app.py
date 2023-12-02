import os.path

from aws_cdk.aws_s3_assets import Asset

from aws_cdk import (
    aws_ec2 as ec2,
    aws_iam as iam,
    App, Stack, CfnParameter
)

from constructs import Construct

dirname = os.path.dirname(__file__)


class PalettizerBotStack(Stack):

    def __init__(self, scope: Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        # VPC
        vpc = ec2.Vpc(
            self, "VPC",
            nat_gateways=0,
            subnet_configuration=[ec2.SubnetConfiguration(name="public", subnet_type=ec2.SubnetType.PUBLIC)]
        )

        # Instance Role and SSM Managed Policy
        role = iam.Role(self, "InstanceSSM", assumed_by=iam.ServicePrincipal("ec2.amazonaws.com"))

        role.add_managed_policy(iam.ManagedPolicy.from_aws_managed_policy_name("AmazonSSMManagedInstanceCore"))

        # Instance
        instance = ec2.Instance(
            self, "Instance",
            instance_type=ec2.InstanceType("t3.micro"),
            machine_image=ec2.MachineImage.latest_amazon_linux2023(),
            vpc=vpc,
            role=role
        )

        # Script in S3 as Asset
        asset = Asset(self, "Asset", path=os.path.join(dirname, "configure.sh"))
        local_path = instance.user_data.add_s3_download_command(
            bucket=asset.bucket,
            bucket_key=asset.s3_object_key,
            local_file="/usr/local/etc/startup.sh"
        )

        # Parameter for the script - Telegram Bot API token
        bot_token = CfnParameter(self, "botToken", type="String",
                                 description="API token for the Telegram Bot")

        # Userdata executes script from S3
        instance.user_data.add_execute_file_command(
            file_path=local_path,
            arguments=bot_token.value_as_string
            )
        asset.grant_read(instance.role)


app = App()
PalettizerBotStack(app, "palettizer-bot")

app.synth()
