# ISSUES:
# TODAY is cached, and therefore reflects configure time
# I'd like this to correspond with a target, so that it can be self-contained
# and live entirely in its own directory.  additionally, that provides more
# information for when to update (may conflict with datetime?), and having a target
# for linking the header file is nice/neat/expected cmake interface

execute_process(COMMAND git log --pretty=format:'%h' -n 1
                OUTPUT_VARIABLE GIT_REV
                ERROR_QUIET)
execute_process(COMMAND git show --quiet --date=format-local:%Y-%m-%dT%H:%M:%SZ --format=%cd
                OUTPUT_VARIABLE GIT_DATE
                ERROR_QUIET)

# Check whether we got any revision (which isn't
# always the case, e.g. when someone downloaded a zip
# file from Github instead of a checkout)
if ("${GIT_REV}" STREQUAL "")
    set(GIT_REV "N/A")
    set(GIT_DIFF "")
    set(GIT_TAG "N/A")
    set(GIT_BRANCH "N/A")
else()
    execute_process(
        COMMAND bash -c "git diff --quiet --exit-code || echo +"
        OUTPUT_VARIABLE GIT_DIFF)
    execute_process(
        COMMAND git describe --exact-match --tags
        OUTPUT_VARIABLE GIT_TAG ERROR_QUIET)
    execute_process(
        COMMAND git rev-parse --abbrev-ref HEAD
        OUTPUT_VARIABLE GIT_BRANCH)

    string(STRIP "${GIT_REV}" GIT_REV)
    string(SUBSTRING "${GIT_REV}" 1 7 GIT_REV)
    string(STRIP "${GIT_DIFF}" GIT_DIFF)
    string(STRIP "${GIT_TAG}" GIT_TAG)
    string(STRIP "${GIT_BRANCH}" GIT_BRANCH)
    string(STRIP "${GIT_DATE}" GIT_DATE)
endif()

string(TIMESTAMP TODAY "%Y-%m-%dT%H:%M:%SZ")

MESSAGE(STATUS "REV ${GIT_REV}")
MESSAGE(STATUS "BRANCH ${GIT_BRANCH}")
MESSAGE(STATUS "Date ${TODAY}")
MESSAGE(STATUS "Tag ${GIT_TAG}")
MESSAGE(STATUS "VCS Date ${GIT_DATE}")
# application version info?
# https://github.com/sbellus/json-cmake
# file(READ ${VERSION_FILE} VERSION_)
# It may be useful to read a version number from a file, and construct some
# modifiers to it based on repo state
# example being:
# VERSION_FILE contains: 4.2.54
# With a modified repo, we can append some useful modifiers
# 4.2.54+BUILD_DATE+GIT_REV

CONFIGURE_FILE(cmake/version.hh.in header/version.hh)
