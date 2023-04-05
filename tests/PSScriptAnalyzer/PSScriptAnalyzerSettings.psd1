@{
    Severity            = @(
        'Error'
        'Warning'
        'Information'
    )

    IncludeDefaultRules = $true

    IncludeRules        = @(
        # Default rules
        'AvoidSemicolonsAsLineTerminators',
        'AvoidUsingDoubleQuotesForConstantString',
        'PSAlignAssignmentStatement',
        'PlaceCloseBrace',
        'PlaceOpenBrace',
        'UseConsistentWhitespace',
        'UseConsistentIndentation',
        'UseCorrectCasing'
    )

    Rules               = @{
        PSAlignAssignmentStatement = @{
            Enable         = $true
            CheckHashtable = $true
        };
        PSUseConsistentIndentation = @{
            Enable              = $true
            IndentationSize     = 4
            PipelineIndentation = 'IncreaseIndentationForFirstPipeline'
            Kind                = 'space'
        };
        PSUseConsistentWhitespace  = @{
            Enable                                  = $true
            CheckInnerBrace                         = $true
            CheckOpenBrace                          = $false
            CheckOpenParen                          = $false
            CheckOperator                           = $false
            CheckPipe                               = $true
            CheckPipeForRedundantWhitespace         = $false
            CheckSeparator                          = $true
            CheckParameter                          = $false
            IgnoreAssignmentOperatorInsideHashTable = $false
        }
        PSAvoidSemicolonsAsLineTerminators = @{
            Enable = $true
        }
        PSPlaceCloseBrace                  = @{
            Enable             = $true;
            NoEmptyLineBefore  = $false;
            IgnoreOneLineBlock = $true;
            NewLineAfter       = $true;
        }
        PSPlaceOpenBrace                   = @{
            Enable             = $true;
            OnSameLine         = $true;
            NewLineAfter       = $true;
            IgnoreOneLineBlock = $true;
        }
    }
}