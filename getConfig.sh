#!/bin/bash
aws cloudformation list-exports --query 'Exports[?Name==`template-security-'"$STAGE"'`].Value' --output text > lambdarolearn.txt
aws cloudformation list-exports --query 'Exports[?Name==`template-security-secrets-'"$STAGE"'`].Value' --output text > s3.txt
aws codepipeline --region us-east-1 get-pipeline-state --name $PIPELINE | jq -r '.stageStates[0].actionStates[0].currentRevision.revisionId' > securityhash.txt
aws codepipeline --region us-east-1 get-pipeline-state --name $PIPELINE | jq -r '.stageStates[0].actionStates[1].currentRevision.revisionId' > apphash.txt
