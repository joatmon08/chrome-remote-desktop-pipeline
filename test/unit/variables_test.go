package unit

import (
	"os"
	"testing"
)

var packerVariables = []string{
	"GOOGLE_APPLICATION_CREDENTIALS",
	"TF_VAR_crd_code",
	"TF_VAR_crd_pin",
	"TF_VAR_image",
	"TF_VAR_crd_user",
	"TF_VAR_public_key",
	"TF_VAR_prefix",
}

func TestRequiredVariablesSet(t *testing.T) {
	for _, variable := range packerVariables {
		if _, ok := os.LookupEnv(variable); !ok {
			t.Errorf("%s is undefined", variable)
		}
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
