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

func TestGoogleSSHPublicKey(t *testing.T) {
	_, ok := os.LookupEnv("SSH_PUBLIC_KEY")
	if !ok {
		t.Errorf("%s is undefined", "SSH_PUBLIC_KEY")
	}
}

func TestTFCloudOverrideVariables(t *testing.T) {
	tfCloudVars := []string{
		"TF_VAR_crd_code",
		"TF_VAR_region",
	}
	for _, v := range tfCloudVars {
		_, ok := os.LookupEnv(v)
		if !ok {
			t.Errorf("%s is undefined", v)
		}
	}
}
