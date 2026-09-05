Feature: Create a Campaign by using POST HTTP request method

  Background:

    * def loginResponse = callonce read('classpath:features/auth/login.feature')

    * def token = loginResponse.token
    * def tenantId = loginResponse.tenantId



  Scenario: Create Campaign with segment ID and email template Id which used to as pre-requisites

    * def reqBody = read('classpath:payload/campaign.json')
    * print "Print request Body: ", reqBody

    * def campaignRequest = reqBody

    * print "Print request Body: ", campaignRequest
#    """
#    {
#        "name": "Campaign More Info Required_test_16",
#        "templateId": "37472ac8-ed24-45ed-a109-74c9e0a39c4a",
#        "template_version_id": "de968230-25c9-45d2-9303-a434f7a95fcf",
#        "segmentId": "7cb21d2e-2164-41f0-ba49-6c6d3c7d007c",
#        "sendOption": "immediate",
#        "scheduledAt": null,
#        "subject": "Quick Bond Approval for Your Business",
#        "organizationId": "00000000-0000-0000-0000-000000000000"
#    }
#    """

    * def randomVal = Math.floor(Math.random() * 1000)
    * print "Random Number: ", randomVal

    * def newCompanyName = "Campaign More Info Required_test_" + randomVal

    * set campaignRequest.name = newCompanyName

    * print "Print After Modifying Data: ", reqBody

#    * remove reqBody.templateId

    * def address =
    """
    {
      "city": "Tempe",
      "state": "AZ"
    }
    """

    * def additionalAddress =
    """
    {
      "city": "Dallas",
      "state": "TX"
    }
    """

    * def combinedAddress = karate.merge(address, additionalAddress)
    * print "combined address: ", combinedAddress

    Given url baseUrl
    And header Authorization = 'Bearer ' + token
    And header X-Tenant-ID = tenantId
    And path "/lead/api/campaigns"
    And request reqBody
    When method post
    Then status 201

    * print "Response for sucessful Campaign Creation:  ", response

    * def campaignId = response.id