@{
    IncludeRules = @('PSAlignAssignmentStatement',
        'AvoidUsingDoubleQuotesForConstantString',
        'UseCorrectCasing'
        )
        
    Rules = @{
        PSAlignAssignmentStatement = @{
            Enable         = $true
            CheckHashtable = $true
        }
    }
}