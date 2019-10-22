package contract

import (
	"context"
	"io/ioutil"
	"os"
	"regexp"
	"strings"
	"testing"

	tfc "github.com/hashicorp/go-tfe"
)

type TFCloud struct {
	Client       *tfc.Client
	Organization *string
	Workspace    *string
}

func setup() (*TFCloud, error) {
	home, err := os.UserHomeDir()
	if err != nil {
		return nil, err
	}
	tfCloudFile := home + "/.terraformrc"
	data, err := ioutil.ReadFile(tfCloudFile)
	if err != nil {
		return nil, err
	}
	re := regexp.MustCompile(`\"(.*)\"`)
	token := string(re.Find(data))
	token = token[1 : len(token)-1]

	config := &tfc.Config{
		Token: token,
	}

	client, err := tfc.NewClient(config)
	if err != nil {
		return nil, err
	}

	organization := os.Getenv("TFH_org")
	workspace := os.Getenv("TFH_name")

	cloud := &TFCloud{
		Client:       client,
		Organization: &organization,
		Workspace:    &workspace,
	}
	return cloud, nil
}

func TestTFCloudWorkspaceExists(t *testing.T) {
	cloud, err := setup()
	if err != nil {
		t.Error(err)
	}

	ctx := context.Background()
	if _, err = cloud.Client.Workspaces.Read(ctx, *cloud.Organization, *cloud.Workspace); err != nil {
		t.Fatal(err)
	}
}

func TestTFCloudWorkspaceHasVariables(t *testing.T) {
	cloud, err := setup()
	if err != nil {
		t.Error(err)
	}
	expected := 8

	ctx := context.Background()
	variables, err := cloud.Client.Variables.List(ctx, tfc.VariableListOptions{
		Organization: cloud.Organization,
		Workspace:    cloud.Workspace,
	})
	if err != nil {
		t.Fatal(err)
	}
	if len(variables.Items) < expected {
		t.Errorf("Need to specify all variables, expected %d found %d", expected, len(variables.Items))
	}
}

func TestTFShouldHaveOutputVariables(t *testing.T) {
	expectedVariables := []string{
		"project",
		"user",
		"crd_code",
		"crd_pin",
		"hostname",
		"gcloud_zone",
	}
	data, err := ioutil.ReadFile("../../outputs.tf")
	if err != nil {
		t.Errorf("Could not find output file: %v", err)
	}
	outputs := string(data)

	for _, v := range expectedVariables {
		if !strings.Contains(outputs, v) {
			t.Errorf("Expected %s to be in outputs, got %v", v, outputs)
		}
	}
}
