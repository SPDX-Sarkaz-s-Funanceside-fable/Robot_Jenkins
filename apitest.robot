*** Settings ***
Library    RequestsLibrary
Test Setup     Create Session    plus_api    ${BASE_URL}

*** Variables ***
${BASE_URL}    http://127.0.0.1:5000/plus

*** Test Cases ***
Test Normal Addition
    ${response}    GET On Session    plus_api    /4/5
    Status Should Be    200    ${response}
    Should Be Equal As Numbers   ${response.json()["Result is"]}    9

Test Decimal
    ${response}    GET On Session    plus_api     /5/6
    Status Should Be    200    ${response}
    Should Be Equal As Numbers    11     ${response.json()["Result is"]}

Test Special Characters
    ${response}=     GET On Session    plus_api    /100/a    expected_status=404
    Status Should Be    404             ${response}

Test Large integer
    ${response}    GET On Session    plus_api    /2948939849/2424124124
    Status Should Be    200    ${response}
    Should Be Equal As Numbers    5373063973    ${response.json()["Result is"]}


Test Below Zero
    ${response}    GET On Session    plus_api    /-500/-300
    Status Should Be    200    ${response}
    Should Be Equal As Numbers    -800    ${response.json()["Result is"]}

Test Positive int and Negative int
    ${response}    GET On Session    plus_api     /-500/100
    Status Should Be    200     ${response}
    Should Be Equal As Numbers    -400    ${response.json()["Result is"]}

