from typing import Dict, Tuple
from data import EmailRequest, ContactUsInfo, LambdaResponse
import boto3
import codecs
import json

client = boto3.client('ses')


def send_email(to_address : str, subject: str, body: str ) -> None:

    # Note: As long as SES is in sandbox mode, this will only work for verified email addresses
    
    print(f"sending email to: {to_address} // {subject}")
    response = client.send_email(
        Source=to_address,
        Destination={
            'ToAddresses': [
                to_address
            ]
        },
        Message={
            'Subject': {
                'Data': subject
            },
            'Body': {
                'Html': {
                    'Data': body,
                }
            }
        },
        ReplyToAddresses=[
            to_address,
        ]
    )
    print(f"Sent Email: {response}")


def format_email_from_contact_us(form_content: ContactUsInfo ) -> Tuple[str, str]:
    email_subject = "WCRENT - New Client Request!"
    f = codecs.open('ContactUsTemplate.html', 'r')
    email_template = f.read()
    email_template = email_template.replace("##CLIENTNAME", form_content.client_name)
    email_template = email_template.replace("##CLIENTEMAIL", form_content.client_email)
    email_template = email_template.replace("##CLIENTPHONE", form_content.clinet_phone)
    email_template = email_template.replace("##SERVICETYPE", form_content.service_type)
    email_template = email_template.replace("##ADDRESS", form_content.address)
    email_template = email_template.replace("##CITY", form_content.city)
    email_template = email_template.replace("##STATE", form_content.state)
    email_template = email_template.replace("##ZIPCODE", form_content.zipcode)
    email_template = email_template.replace("##DESCRIPTION", form_content.description)
    return email_template, email_subject


def main(event: Dict, context: Dict) -> LambdaResponse:
    print("Processing Email Reqeust...")
    email_request =  EmailRequest(**json.loads(event["body"]))

    # This is really just me getting overzealous as I only have one case here, but for anyone reading this, 
    # You check for valid purposes / handle unique validationsn at this point

    if "Contact Us" in email_request.purpose:
        client_info_content = ContactUsInfo(**email_request.content)
        email_body, email_subject = format_email_from_contact_us(client_info_content)
        send_email(email_request.recipient, email_subject, email_body)
        print("email sent")
        response: LambdaResponse = {
            "headers" : {"Content-Type": "application/json"},
            "statusCode": 201,
            "isBase64Encoded": True,
            "body" : "Processing Request"
        }
        return json.dumps(response)

    else:
        print("Email Request is missing appropriate purpose")
        response: LambdaResponse = {
            "headers" : {"Content-Type": "application/json"},
            "statusCode": 400,
            "isBase64Encoded": True,
            "body" : "Invalid Email Purpose"
        }
        return json.dumps(response)


def lambda_handler(*args, **kwargs):
    return main(*args, **kwargs)