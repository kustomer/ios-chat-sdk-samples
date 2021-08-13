//
//  Constants.swift
//  swift-chat-v2-sample
//
//  Created by Miranda Strand on 8/11/21.
//

import Foundation

struct Constants {
    /**
     API Key for your Kustomer organization.
     YOU NEED TO REPLACE THIS FOR THE SAMPLE APP TO WORK
     See instructions below for generating the API key. This key should have the org.tracking role only.
     https://developer.kustomer.com/chat-sdk/v2-iOS/docs#manually-generate-the-api-key
     Copy the token and paste it here.
     */
    static let apiKey = /*"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMTU5NzEwNGI3YTdkMDA4ZWRiMTM2MyIsInVzZXIiOiI2MTE1OTcwYmEwOTBkMDAwMTJmODNkNWMiLCJvcmciOiI2MTExNjQ2MTMwY2U2ODczN2E3ZGMxYWEiLCJvcmdOYW1lIjoienp6LW1pcmFuZGEtc3RhZ2luZyIsInVzZXJUeXBlIjoibWFjaGluZSIsInBvZCI6InN0YWdpbmciLCJyb2xlcyI6WyJvcmcuYWRtaW4iLCJvcmcudHJhY2tpbmciLCJvcmcudXNlciJdLCJhdWQiOiJ1cm46Y29uc3VtZXIiLCJpc3MiOiJ1cm46YXBpIiwic3ViIjoiNjExNTk3MGJhMDkwZDAwMDEyZjgzZDVjIn0.CLRuLtRDGoL4ud5xMaAw1SQuS-xkBYOyVR17ncZCjQ8"*/
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMTJiOGYzZjVjNDgxMDA5NTBkNTAxYyIsInVzZXIiOiI2MTEyYjhlZTEwMGVkMDAwMTMyYjQ1MTciLCJvcmciOiI2MTExNjQ2MTMwY2U2ODczN2E3ZGMxYWEiLCJvcmdOYW1lIjoienp6LW1pcmFuZGEtc3RhZ2luZyIsInVzZXJUeXBlIjoibWFjaGluZSIsInBvZCI6InN0YWdpbmciLCJyb2xlcyI6WyJvcmcudHJhY2tpbmciXSwiYXVkIjoidXJuOmNvbnN1bWVyIiwiaXNzIjoidXJuOmFwaSIsInN1YiI6IjYxMTJiOGVlMTAwZWQwMDAxMzJiNDUxNyJ9.9QPnKsbPdf6CDl4oRJ671GZujGFFe6unQLdg1sE6BuY"

    /**
     JSON Web Token
     YOU NEED TO REPLACE THIS FOR THE SAMPLE APP TO WORK
     In production this will come from your backend. For the sample app, we have a mock network call return the value hard-coded here, which you can generate online and replace every 15 minutes.
        1. To generate tokens, you will first need to get the secret key for your org. You can get the secret key by logging into your org in a browser and navigating to
          https://[YOUR_ORG_NAME].api.kustomerapp.com/v1/auth/customer/settings and copying the field named "secret"
          Alternatively, you can use Postman and follow the instructions here to generate a new API key and then submit a GET request to the Kustomer API: https://jwt.io/#debugger-io?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZha2VAZW1haWwuY29tIiwiaWF0IjoxNjI4ODcyNTQ4fQ.xF2D-eut9cf-SN6u7-50WdPAFTptSeFaR7CTMTgTojo
          Note that the API key you use on Postman will NOT be same API key you use above for the app, because the permissions it needs are different.
          The API key to use chat SDK must have org.tracking role only, while the API key for requesting the secret key will need org.admin and org.user.
        2. Once you have your secret key, you can save it to generate all your future JWTs.
        3. To generate a new JWT, go to the JWT generator at https://jwt.io/
            a. In the PAYLOAD: DATA section, enter the key-value pairs for either email or externalId
            b. In PAYLOAD:DATA section, replace the iat value with one created within the last 15 minutes.
              You can get a current iat at https://www.epochconverter.com/ - just copy the value at t he top of the page for current Unix epoch time.
            c. In the VERIFY SIGNATURE section, replace your-256-bit-secret with the secret key you generated for your Kustomer organization.
            d. Copy the value on the Encoded side (or click Share JWT to copy it to clipboard) and paste the value into the string below.
              Note: if you copied it with the button and the full URL is pasted, remove "https://jwt.io/#debugger-io?token=" and include the token value only.
        4. This JWT will be valid for 15 minutes from the iat value time, but when it expires you do not need to start over. If you leave the https://jwt.io/ window and
          https://www.epochconverter.com/ open, you can quickly get new JWTs by replacing only the iat value in PAYLOAD:DATA with the current epoch time.
     */
    static let jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZha2VAZW1haWwuY29tIiwiaWF0IjoxNjI4ODcyNTQ4fQ.xF2D-eut9cf-SN6u7-50WdPAFTptSeFaR7CTMTgTojo"
}
