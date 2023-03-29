Describe "Measure-GitHubRateLimit" {
    It "Should return the current rate limit status" {
        $limit = Measure-GitHubRateLimit
        $limit.Limit | Should -Not -BeNullOrEmpty
        $limit.Remaining | Should -Not -BeNullOrEmpty
        $limit.Reset | Should -Not -BeNullOrEmpty
    }
}
