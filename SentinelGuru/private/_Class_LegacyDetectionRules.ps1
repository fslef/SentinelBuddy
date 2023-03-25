class DetectionRule {
    [string]$id
    [string]$name
    [string]$description
    [string]$severity
    [array]$requiredDataConnectors
    [string]$queryFrequency
    [string]$queryPeriod
    [string]$triggerOperator
    [int]$triggerThreshold
    [array]$tactics
    [string]$query
    [array]$entityMappings
    [string]$version
    [string]$kind
}

# $detectionrule = ConvertFrom-Yaml $yaml -AsType DetectionRule