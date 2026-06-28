---
name: kickoff
description: Start something new. Interview the user, then generate CONTEXT.md, a PRD, and a folder of vertical-slice issues.
---

Load and follow the **kickoff** skill.

You are entering the **KICKOFF** phase of the Stepwise workflow.

Your job:
1. Interview the user one question at a time (purpose, users, constraints, tech stack, scope), recommending an answer each time and exploring the codebase instead of asking where you can.
2. Generate three artifacts: `.workflow/CONTEXT.md` (strict domain glossary), `.workflow/<feature>/PRD.md` (synthesized from the interview), and `.workflow/<feature>/issues/NN-*.md` (vertical-slice issues with acceptance criteria and `blocked-by` dependencies).
3. Print the issue list and tell the user to run `/build`.

Do not write implementation code in this phase. Follow the kickoff skill exactly.

$ARGUMENTS
