export SCRIPTS_HOME="$HOME/workspace/tsuite"
source $SCRIPTS_HOME/tsuite.sh

export TZ=America/Toronto
export PS1='\[\033[01;67m\]\A \[\033[01;32m\]\W\[\033[00m\] '
##################################################################
echo "Welcome to the t-agent container! Your workspace is set up."

alias gemini="gemini --show_memory_usage"

# for example, you are working on a project called "my-current-project"
# cd my-current-project // relative to the workspace directory
# allows you to implicitly use the project directory as the working directory