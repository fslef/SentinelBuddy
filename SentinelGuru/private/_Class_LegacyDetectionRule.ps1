#Requires -PSEdition Core

class LegacyDetectionRule {
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

    LegacyDetectionRule($rule) {
        $this.id = $rule
        # $this.name = $rule.name
        # $this.description = $rule.description
        # $this.severity = $rule.severity
        # $this.requiredDataConnectors = $rule.requiredDataConnectors
        # $this.queryFrequency = $rule.queryFrequency
        # $this.queryPeriod = $rule.queryPeriod
        # $this.triggerOperator = $rule.triggerOperator
        # $this.triggerThreshold = $rule.triggerThreshold
        # $this.tactics = $rule.tactics
        # $this.query = $rule.query
        # $this.entityMappings = $rule.entityMappings
        # $this.version = $rule.version
        # $this.kind = $rule.kind
    }
}