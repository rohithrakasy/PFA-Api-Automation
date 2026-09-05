Feature: Upload Additional Documents  Application

  Background:
    * def loginResp = callonce read('classpath:features/auth/login.feature')

    * def token = loginResp.token
    * def tenantId = loginResp.tenantId

  Scenario: Upload A document through endpoint

     * def uploadFile =
        """
        {
          read: 'classpath:testfiles/Test_Rate_Confirmation_RC-2001.pdf',
          filename: 'Test_Rate_Confirmation_RC-2001.pdf',
          contentType: 'application/pdf'
        }
        """

    Given url baseUrl
    And header Authorization = 'Bearer ' + token
    And header X-Tenant-ID = tenantId
    And path '/lead/api/v1/public/documents/upload'

    And multipart field companyId = '20a9e437-2dbc-4167-9b6d-4fb5e5514bcd'
    And multipart field refId = 'c767facb-e96d-47ee-9e4a-4a14a7714989'
    And multipart field packetCardId = 'signed-application'
    And multipart field documentSubtype = 'SIGNED_APPLICATION'
    And multipart field refType = 'APPLICATION'

    And multipart file file = uploadFile

    When method Post
    Then status 201

    * print "Response: " , response
