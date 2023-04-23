from typing import TypedDict

class ContactUsInfo():
    def __init__(self, clientName: str, clientEmail: str, clientPhone: str, serviceType: str, serviceAddress: str,
                city: str, state: str, zipcode: str, description: str):
        
        # Converts from React's camel case to Python snake case.
        self.client_name: str = clientName
        self.client_email: str = clientEmail
        self.clinet_phone: str = clientPhone
        self.service_type: str = serviceType
        self.address: str = serviceAddress
        self.city: str = city
        self.state: str = state
        self.zipcode: str = zipcode
        self.description: str = description


class EmailRequest():
    def __init__(self, recipient: str, subject: str, purpose: str, content: str):
        self.recipient: str = recipient
        self.subject: str = subject
        self.purpose: str = purpose
        self.content: ContactUsInfo = content


class LambdaResponse(TypedDict):
    statusCode: int
    headers: dict
    body : dict
    isBase64Encoded: bool