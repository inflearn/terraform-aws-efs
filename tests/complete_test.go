package main

import (
	"github.com/gruntwork-io/terratest/modules/test-structure"
	"testing"
)

func TestEfs(t *testing.T) {
	t.Parallel()

	efsTfDir := "../examples/complete"

	defer test_structure.RunTestStage(t, "teardown", func() { teardown(t, efsTfDir) })
	test_structure.RunTestStage(t, "deploy", func() { deploy(t, efsTfDir, map[string]interface{}{}) })
}
