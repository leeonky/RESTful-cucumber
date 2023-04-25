@jfactory
Feature: JFactory Integration

  Background:
    Given base url "http://www.a.com"

  Scenario Outline: <method> with body created by spec
    When <method> "LoginRequest" "/index":
    """
    {
      "username": "admin",
      "captcha": {
        "code": "1234"
      }
    }
    """
    Then "http://www.a.com" got a "<method>" request on "/index" with body matching
    """
    : [{
      method: '<method>'
      path: '/index'
      headers: {
        ['Content-Type']: ['application/json']
      }
      body.json= {
        username: admin,
        password: password#1,
        captcha: {
          code: '1234'
        }
      }
    }]
    """
    Examples:
      | method |
      | POST   |
      | PUT    |

  Scenario Outline: <method> with body array created by spec
    When <method> "LoginRequest" "/index":
    """
    [{
      "username": "admin",
      "captcha": {
        "code": "1234"
      }
    }]
    """
    Then "http://www.a.com" got a "<method>" request on "/index" with body matching
    """
    : [{
      body.json= [{
        username: admin,
        password: password#1,
        captcha: {
          code: '1234'
        }
      }]
    }]
    """
    Examples:
      | method |
      | POST   |
      | PUT    |