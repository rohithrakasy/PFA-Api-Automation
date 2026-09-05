Feature: Create a New Department by using Api Endpoint.

  Background:
    * def  loginResp = callonce read('classpath:features/auth/login.feature')

    * def token = loginResp.token
    * def tenantId = loginResp.tenantId

  Scenario: Create New Department with Name Test and Delete it

    * def dept = ['Audit','Reporting','task','Fraud Alert','Segment','Campaign']

    * def randomDept = dept[Math.floor(Math.random() * dept.length)]

    * print "Selected Random Dept: " , randomDept


    * def deptReqBody =
    """
    {
      "name": "#(randomDept)"
    }
    """

    Given url baseUrl
    And path 'lead','api','departments'
    And header Authorization = 'Bearer ' + token
    And header X-Tenant-ID = tenantId
    And request deptReqBody
    When method post
    Then status 200

    * print "Department ID: ",response

    * def deptId = response.id



    Given url baseUrl
    And path 'lead','api','departments',deptId
    And header Authorization = 'Bearer ' + token
    And header X-Tenant-ID = tenantId
    When method get
    Then status 200

    * print "Response By Get Method: ", response



    Given url baseUrl
    And path 'lead','api','departments',deptId
    And header Authorization = 'Bearer ' + token
    And header X-Tenant-ID = tenantId
    When method delete
    Then status 204
    And print response

    * print "Deleted response: ", response
