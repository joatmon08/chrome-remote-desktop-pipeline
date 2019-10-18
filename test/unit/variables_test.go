package unit

import (
	"os"
	"testing"
)

func TestTFCloudCredentials(t *testing.T) {
	home, err := os.UserHomeDir()
	if err != nil {
		t.Error(err)
	}
	tfCloudFile := home + "/.terraformrc"
	info, err := os.Stat(tfCloudFile)
	if os.IsNotExist(err) {
		t.Errorf("%s does not exist", tfCloudFile)
	}
	if info.Size() == 0 {
		t.Errorf("%s does not have content", tfCloudFile)
	}
}
