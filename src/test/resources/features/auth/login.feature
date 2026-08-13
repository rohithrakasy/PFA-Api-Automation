Feature: Login API

  Scenario: Login and retrieve authentication details

    * def loginPayload = read('classpath:payload/loginData.json')

    Given url baseUrl
    And path 'api','auth','userlogin'
    And request loginPayload

    When method POST
    Then status 200

    * print 'Login Response: ', response

    * def token = response.token
    * def tenantId = response.payload.user.tenant_id.id

    * print "Token: ", token
    * print "Tenant ID: ", tenantId



