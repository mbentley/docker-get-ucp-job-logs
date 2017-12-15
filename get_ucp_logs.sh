#!/bin/sh

set -e

# check to see if show debug info
if [ "${DEBUG}" = true ] || [ "${DEBUG}" = "1" ]
then
  set -x
fi

# make sure all variable have been provided
if [ -z "${UCP_URL}" ]
then
  echo "Missing UCP_URL environment variable"
  exit 1
fi

if [ -z "${USERNAME}" ]
then
  echo "Missing USERNAME environment variable"
  exit 1
fi

if [ -z "${PASSWORD}" ]
then
  echo "Missing PASSWORD environment variable"
  exit 1
fi

if [ -z "${JOB_TYPE}" ] && [ -z "${JOB_ID}" ]
then
  echo "Missing JOB_TYPE environment variable"
  echo "Valid types: any cleanup-db ldap-sync"
  exit 1
fi

JOB_LIMIT="${JOB_LIMIT:-10}"
JOB_INFO_ONLY="${JOB_INFO_ONLY:-false}"
JOB_ID="${JOB_ID:-}"

# get job info
if [ -z "${JOB_ID}" ]
then
  # get job info based off of JOB_LIMIT, JOB_TYPE
  JOBS="$(curl -ks -X GET --header "Accept: application/json" -u "${USERNAME}:${PASSWORD}" "https://${UCP_URL}/enzi/v0/jobs?action=${JOB_TYPE}&limit=${JOB_LIMIT}" | jq '.jobs|.[]')"
else
  # get job info based off of JOB_ID
  echo "Ignoring values for JOB_LIMIT and JOB_TYPE as a single JOB_ID was provided"
  JOBS="$(curl -ks -X GET --header "Accept: application/json" -u "${USERNAME}:${PASSWORD}" "https://${UCP_URL}/enzi/v0/jobs/${JOB_ID}")"
fi

# check to see if we should return a list of the jobs or get the logs for the jobs
if [ "${JOB_INFO_ONLY}" = true ] || [ "${JOB_INFO_ONLY}" = "1" ]
then
  # display info about matching jobs
  echo "${JOBS}"
  exit 0
fi

# get job id(s)
JOB_IDS="$(echo "${JOBS}" | jq -r .id)"

# check to see if job id returned null
if [ "${JOB_IDS}" = "null" ]
then
  echo "No jobs found of type '${JOB_TYPE}'"
  exit 1
fi

# get the job logs for each job
for JOB in ${JOB_IDS}
do
  echo "====== BEGIN job logs from ${JOB} ======"
  # output info about the job
  curl -ks -X GET --header "Accept: application/json" -u "${USERNAME}:${PASSWORD}" "https://${UCP_URL}/enzi/v0/jobs/${JOB}" | jq .
  echo

  # get job job id from the last ${JOB_TYPE} job and send that to get the job logs
  #curl -ks -X GET --header "Accept: application/json" -u "${USERNAME}:${PASSWORD}" "https://${UCP_URL}/enzi/v0/jobs/${JOB}/logs" | jq -r .[].Data
  curl -ks -X GET --header "Accept: application/json" -u "${USERNAME}:${PASSWORD}" "https://${UCP_URL}/enzi/v0/jobs/${JOB}/logs"
  echo "====== END job logs from ${JOB} ======"; echo
done
