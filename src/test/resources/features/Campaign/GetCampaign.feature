Feature: Fetch API details using campaign Id

  Background:
    * def loginResp = callonce read('classpath:features/auth/login.feature')

    * def token = loginResp.token
    * def tenantId = loginResp.tenantId

  @smoke @regression
  Scenario: Fetch Campaign Details Successfully

    * def campaignIdResponse = call read('classpath:features/Campaign/CreateCampaign.feature')

    * def campaignId = campaignIdResponse.campaignId

    Given url baseUrl
    And path 'lead','api','campaigns',campaignId
    And header Authorization = 'Bearer ' + token
    And header X-Tenant-ID = tenantId
    When method get
    Then status 200

    * print "Fetch Campaign Details: ", response

    * print "Response Time: " , responseTime

    * assert responseTime < 1000

    And match response.id == campaignId

    Given url baseUrl
    And header Authorization = 'Bearer ' + token
    And header X-Tenant-ID = tenantId
    And path '/lead/api/campaigns',campaignId
    When method Delete
    Then status 200

    * print "Response of Deleted Campaign: " , response

    * assert responseTime <= 1000

    * def responseMessage = response.message
    * def campaignIdDelete = response.campaignId

    * print " Response Message: " , responseMessage
    * print " Response Deleted Campaign ID: " , campaignIdDelete

    * match responseMessage contains  'deleted successfully.'
    * match campaignIdDelete ==  campaignId
