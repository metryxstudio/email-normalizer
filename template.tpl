___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.

___INFO___

{
  "type": "MACRO",
  "id": "email_normalizer",
  "version": 1,
  "securityGroups": [],
  "displayName": "Email Address Normalizer",
  "description": "Normalizes email addresses for server-side tracking by converting to lowercase, trimming whitespace, and applying Gmail-specific rules (dots, plus addressing).",
  "containerContexts": [
    "SERVER",
    "WEB"
  ],
  "categories": ["UTILITY"],
  "brand": {
    "id": "metryxstudio",
    "displayName": "Metryx Studio"
  }
}

___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "rawEmail",
    "displayName": "Raw Email Address",
    "simpleValueType": true,
    "help": "The email address in its original form."
  }
]

___SANDBOXED_JS_FOR_SERVER___

var makeString = require('makeString');

var normalizeEmail = function(data) {
  var rawEmail = data.rawEmail;

  if (!rawEmail) {
    return undefined;
  }

  var emailString = makeString(rawEmail).trim().toLowerCase();
  
  if (emailString.length === 0) {
    return undefined;
  }
  
  var atIndex = emailString.indexOf('@');
  if (atIndex <= 0 || atIndex === emailString.length - 1) {
    return undefined;
  }
  
  var domain = emailString.substring(atIndex + 1);
  
  if (domain === 'gmail.com' || domain === 'googlemail.com') {
    var localPart = emailString.substring(0, atIndex);
    
    var plusIndex = localPart.indexOf('+');
    if (plusIndex !== -1) {
      localPart = localPart.substring(0, plusIndex);
    }
    
    var normalizedLocal = '';
    for (var i = 0; i < localPart.length; i++) {
      var char = localPart.charAt(i);
      if (char !== '.') {
        normalizedLocal = normalizedLocal + char;
      }
    }
    
    return normalizedLocal + '@gmail.com';
  }
  
  return emailString;
};

return normalizeEmail(data);


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

var makeString = require('makeString');

var normalizeEmail = function(data) {
  var rawEmail = data.rawEmail;

  if (!rawEmail) {
    return undefined;
  }

  var emailString = makeString(rawEmail).trim().toLowerCase();
  
  if (emailString.length === 0) {
    return undefined;
  }
  
  var atIndex = emailString.indexOf('@');
  if (atIndex <= 0 || atIndex === emailString.length - 1) {
    return undefined;
  }
  
  var domain = emailString.substring(atIndex + 1);
  
  if (domain === 'gmail.com' || domain === 'googlemail.com') {
    var localPart = emailString.substring(0, atIndex);
    
    var plusIndex = localPart.indexOf('+');
    if (plusIndex !== -1) {
      localPart = localPart.substring(0, plusIndex);
    }
    
    var normalizedLocal = '';
    for (var i = 0; i < localPart.length; i++) {
      var char = localPart.charAt(i);
      if (char !== '.') {
        normalizedLocal = normalizedLocal + char;
      }
    }
    
    return normalizedLocal + '@gmail.com';
  }
  
  return emailString;
};

return normalizeEmail(data);



___WEB_PERMISSIONS___

[]


___SERVER_PERMISSIONS___

[]


___TESTS___

scenarios:
- name: Uppercase and whitespace
  code: |-
    const mockData = {
      rawEmail: ' Ivan.Petric@GMAIL.COM '
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('ivanpetric@gmail.com');
- name: Empty input returns undefined
  code: |-
    const mockData = {
      rawEmail: ''
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(undefined);
- name: Valid non-Gmail email
  code: |-
    const mockData = {
      rawEmail: 'test@mail.hr'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('test@mail.hr');
- name: Only whitespace returns undefined
  code: |-
    const mockData = {
      rawEmail: '  '
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(undefined);
- name: Gmail dots normalization
  code: |-
    const mockData = {
      rawEmail: 'john.doe@gmail.com'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('johndoe@gmail.com');
- name: Gmail plus addressing
  code: |-
    const mockData = {
      rawEmail: 'user+tag@gmail.com'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('user@gmail.com');
- name: Gmail dots and plus combined
  code: |-
    const mockData = {
      rawEmail: 'John.Doe+newsletter@GMAIL.COM'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('johndoe@gmail.com');
- name: Googlemail alias normalized to gmail
  code: |-
    const mockData = {
      rawEmail: 'user@googlemail.com'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('user@gmail.com');
- name: Invalid email without at sign returns undefined
  code: |-
    const mockData = {
      rawEmail: 'invalidemail.com'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(undefined);
- name: Invalid email only at sign returns undefined
  code: |-
    const mockData = {
      rawEmail: '@gmail.com'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(undefined);
- name: Non-Gmail preserves dots and plus
  code: |-
    const mockData = {
      rawEmail: 'john.doe+tag@outlook.com'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('john.doe+tag@outlook.com');
- name: Undefined input returns undefined
  code: |-
    const mockData = {};
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(undefined);
