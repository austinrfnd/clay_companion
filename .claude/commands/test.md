---
description: Run the complete test suite and get a clear status report
---

Launch the test-suite-runner agent to execute the test suite and provide a detailed status report.

The test-suite-runner agent will:
1. Run the complete RSpec test suite using Docker
2. Analyze test results (passing, failing, errors)
3. If all tests pass, confirm the code is ready
4. If tests fail, investigate and provide a detailed breakdown of issues

Use the Task tool with subagent_type="test-suite-runner" and provide this prompt:

"Run the complete test suite for this Rails project using Docker. Execute all RSpec tests and provide a clear status report. If all tests pass, confirm the code is ready. If any tests fail, investigate the failures and provide detailed information about what went wrong so it can be fixed."
