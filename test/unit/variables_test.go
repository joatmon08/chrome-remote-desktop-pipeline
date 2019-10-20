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

func TestGoogleCredentials(t *testing.T) {
	filename, ok := os.LookupEnv("GOOGLE_APPLICATION_CREDENTIALS")
	if !ok {
		t.Errorf("%s is undefined", "GOOGLE_APPLICATION_CREDENTIALS")
	}
	info, err := os.Stat(filename)
	if os.IsNotExist(err) {
		t.Errorf("%s does not exist", filename)
	}
	if info.Size() == 0 {
		t.Errorf("%s does not have content", filename)
	}
}
