Feature: Fetch API details using campaign Id

  Background:
    * def loginResp = callonce read('classpath:features/auth/login.feature')

    * def token = loginResp.token
    * def tenantId = loginResp.tenantId

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

    And match response.id == campaignId