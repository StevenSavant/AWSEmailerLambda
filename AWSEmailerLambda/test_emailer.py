
from emailer import main
from data import ContactUsInfo, LambdaResponse
import codecs
import json

test_request_form_info = {
    "clientName" : "Steven Burrell",
    "clientEmail" : "stevensavant@gmail.com",
    "clientPhone" : "555-555-5555",
    "serviceType" : "Miscellaneous",
    "serviceAddress" : "802 Hunter Ridge Lane",
    "city" : "Atlanta",
    "state" : "Georgia",
    "zipcode" : "30396",
    "description" : "This is test request about a project to build a mansion on the moon."
}

test_request = {
    "recipient": "stevensavant@gmail.com",
    "subject": "subject",
    "purpose": "Contact Us",
    "content": test_request_form_info
}

def test_send_email():
    event, context = { "body" : json.dumps(test_request) }, {}
    response = main(event, context)
    assert type(response) == str



