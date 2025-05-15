import yaml
import os

with open('.github/pipeline-config.yml') as f:
    config = yaml.safe_load(f)

workflow = {
    'name': f"CI/CD Pipeline - {config['project']['name']}",
    'on': {
        'push': {'branches': [config['branching']['default_branch']]},
        'pull_request': {'branches': ['*']}
    },
    'env': {
        'TECH_STACK': config['project']['tech_stack'],
        'BUILD_TOOL': config['project']['build_tool'],
        'DEPLOY_METHOD': config['project']['deployment']
    }
}

jobs = {}
for stage in config['workflow']['stages']:
    jobs[stage] = {'uses': f'.github/templates/{stage}.yml'}

workflow['jobs'] = jobs

os.makedirs('.github/workflows', exist_ok=True)
with open('.github/workflows/pipeline.yml', 'w') as f:
    yaml.dump(workflow, f, sort_keys=False)
