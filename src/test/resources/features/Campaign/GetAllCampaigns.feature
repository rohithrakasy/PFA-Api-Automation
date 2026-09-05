@regression
Feature: Get Campaigns by Get API Endpoint

  Background:
    * def loginresponse = callonce read('classpath:features/auth/login.feature')

    * def token = loginresponse.token
    * def tenantId = loginresponse.tenantId

  @smoke
  Scenario: Fetch all Campaigns Successfully

    * def randomValueUtils = call read('classpath:utils/testDataGenerator.js')

    * def randomValue = randomValueUtils.randomValueGenerator();

    * print "Generate Random Value: " , randomValue

    Given url baseUrl
    And header Authorization = 'Bearer ' + token
    And header X-Tenant-ID = tenantId
    And path 'lead','api','campaigns'
    And param page = 2
    And param size = 20
    When method get
    Then status 200

    And print "Fetch ALl Campaigns: ", response

    * def draftStatus = karate.filter(response.content, function(x){ return x.status == 'draft'})

    * def draftStatusNames = karate.map(draftStatus, function(x){ return x.name})
    * print "Draft Status: ", draftStatus
    * print "Draft Campaign Names: ", draftStatusNames
    * print "Number of campaigns in Page 1: ", draftStatus.length
    * print "Number of campaign Names in Page 1: ", draftStatusNames.length

    ##Use If else

    * def funcInputValue = response.content

    * def useConditionsFetchResponse =
    """
    function(funcInputValue){

        for(let i=0; i< funcInputValue.length ; i++){

            if(funcInputValue[i].status == 'draft'){

                karate.log('Campaign Status is Draft: ' + funcInputValue[i].name);
            }else {
                karate.log('Campaign is not draft: ' + funcInputValue[i].name);
            }
        }
    }
    """
#    * def printResult = useConditionsFetchResponse(funcInputValue);

* eval useConditionsFetchResponse(funcInputValue);

#    * print "Result: " , printResult