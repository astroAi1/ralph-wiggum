#!/bin/bash
# Ralph Wiggum - Continuous AI Loop Script
# Usage: ./ralph.sh [max_iterations] [prompt_file] [model]
# Models: opus (default), sonnet, haiku

set -e

MAX_ITERATIONS=${1:-10}
PROMPT_FILE=${2:-"prompt.md"}
MODEL=${3:-"opus"}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Map model names to Claude model IDs
case "$MODEL" in
  opus)
    MODEL_ID="claude-opus-4-5-20251101"
    ;;
  sonnet)
    MODEL_ID="claude-sonnet-4-5-20250929"
    ;;
  haiku)
    MODEL_ID="claude-3-5-haiku-20241022"
    ;;
  *)
    # Assume it's a full model ID
    MODEL_ID="$MODEL"
    ;;
esac

# Resolve prompt file path
if [[ "$PROMPT_FILE" != /* ]]; then
  PROMPT_FILE="$SCRIPT_DIR/$PROMPT_FILE"
fi

# Check if prompt file exists
if [[ ! -f "$PROMPT_FILE" ]]; then
  echo "❌ Error: Prompt file not found: $PROMPT_FILE"
  echo "Usage: $0 [max_iterations] [prompt_file] [model]"
  echo "Models: opus (default), sonnet, haiku"
  exit 1
fi

# Check if amp is installed
if ! command -v amp &> /dev/null; then
  echo "❌ Error: 'amp' CLI not found"
  echo "Install it with: npm install -g @anthropic-ai/amp"
  exit 1
fi

echo "🚀 Starting Ralph Wiggum Loop"
echo "📄 Prompt file: $PROMPT_FILE"
echo "🔄 Max iterations: $MAX_ITERATIONS"
echo "🤖 Model: $MODEL ($MODEL_ID)"
echo ""

for i in $(seq 1 $MAX_ITERATIONS); do
  echo "═══════════════════════════════════════"
  echo "═══ Iteration $i of $MAX_ITERATIONS ═══"
  echo "═══════════════════════════════════════"
  echo ""

  OUTPUT=$(cat "$PROMPT_FILE" \
    | amp --model "$MODEL_ID" --dangerously-allow-all 2>&1 \
    | tee /dev/stderr) || true

  # Check for completion marker
  if echo "$OUTPUT" | grep -q "<promise>COMPLETE</promise>"; then
    echo ""
    echo "✅ Loop completed successfully!"
    echo "🎉 Task marked as COMPLETE in iteration $i"
    exit 0
  fi

  # Check for blocker marker
  if echo "$OUTPUT" | grep -q "<promise>BLOCKED</promise>"; then
    echo ""
    echo "⚠️  Loop blocked - requires user input"
    echo "🛑 Stopped at iteration $i"
    exit 2
  fi

  # Wait before next iteration
  if [ $i -lt $MAX_ITERATIONS ]; then
    echo ""
    echo "⏳ Waiting 2 seconds before next iteration..."
    sleep 2
    echo ""
  fi
done

echo ""
echo "⚠️  Max iterations ($MAX_ITERATIONS) reached without completion"
echo "💡 You may need to:"
echo "   - Increase max iterations"
echo "   - Refine the prompt"
echo "   - Check for blockers in the output"
exit 1
