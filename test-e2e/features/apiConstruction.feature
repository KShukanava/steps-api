Feature: Construction API

  Scenario: Verify simple send
    Given I create 'GET' request 'request'
    And I add 'https://jsonplaceholder.typicode.com/todos/1' url to '$request'
    And I send '$request' request and save response as 'response'
    And I parse '$response' body as json
    Then Response '$response' Status Code to be equal '200'
    And Response '$response' Status Message to be equal 'OK'
    Then Response '$response.payload' contains:
      | userId    |
      | id        |
      | title     |
      | completed |
    Then I expect '$response.payload.userId' memory value to be equal '$number(1)'
    Then I expect '$response.payload.id' memory value to be equal '$number(1)'
    Then I expect '$response.payload.title' memory value to be equal 'delectus aut autem'
    Then I expect '$response.payload.completed' memory value to be equal '$boolean("false")'

  Scenario: Verify POST with valid request body as Cucumber Doc String
    Given I create 'POST' request 'request'
    And I add 'https://jsonplaceholder.typicode.com/posts' url to '$request'
    And I add body to '$request':
    """
      {
        "userId": 1,
        "id": 1,
        "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
      }
    """
    And I send '$request' request and save response as 'response'
    And I parse '$response' body as json
    Then Response '$response' Status Code to be equal '201'
    And Response '$response' Status Message to be equal 'Created'

  Scenario: Verify POST with valid request body as file
    Given I create 'POST' request 'request'
    And I add 'https://jsonplaceholder.typicode.com/posts' url to '$request'
    And I add '$textFile("testData/test_data_file.json")' body to '$request'
    And I send '$request' request and save response as 'response'
    And I parse '$response' body as json
    Then Response '$response' Status Code to be equal '201'
    And Response '$response' Status Message to be equal 'Created'
    And Response '$response.payload' contains:
      | userId |
      | id     |
      | title  |
      | body   |

  Scenario: Verify POST with headers
    Given I create 'POST' request 'request'
    And I add 'http://qavajsmock.org/echo' url to '$request'
    And I add headers to '$request':
      | customHeader | 42 |
    And I send '$request' request and save response as 'response'
    And I parse '$response' body as json
    Then Response '$response' Status Code to be equal '200'
    And Response '$response' Status Message to be equal 'OK'
    Then I expect '$response.payload.requestHeaders.customheader' memory value to be equal '$array("42")'

  Scenario: Verify simple send and parse it as text
    When I create 'GET' request 'request'
    And I add 'http://qavajsmock.org/text' url to '$request'
    And I send '$request' request and save response as 'response'
    And I parse '$response' body as text
    Then Response '$response' Status Code to be equal '200'
    And Response '$response' Status Message to be equal 'OK'
    Then I expect '$response.payload' memory value to be equal 'hello qavajs'

  Scenario: Verify simple send and parse it as text
    When I create 'GET' request 'request'
    And I add 'http://qavajsmock.org/text' url to '$request'
    And I send '$request' request and save response as 'response'
    Then Response '$response' Status Code to be equal '200'
    And Response '$response' Status Message to be equal 'OK'
    Then I expect '$response.payload' memory value to be equal 'hello qavajs'
