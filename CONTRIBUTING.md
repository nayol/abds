# Contributing to ABDS

Thank you for your interest in improving the Agent Base Directory Specification!

## How to Contribute

ABDS is an open specification - anyone can contribute improvements.

### Ways to Contribute

1. **Report Issues**
   - Ambiguities in the spec
   - Missing use cases
   - Unclear requirements
   - Inconsistencies

2. **Propose Improvements**
   - Additional templates
   - Better examples
   - Clarified wording
   - New sections

3. **Share Implementations**
   - ABDS-compliant projects
   - Tools and helpers
   - Migration scripts

4. **Improve Documentation**
   - Fix typos
   - Add examples
   - Expand explanations

## Contribution Process

1. **Open an Issue First**
   - Discuss the change before implementing
   - Get feedback from maintainers and community
   - Ensure alignment with ABDS principles

2. **Create a Pull Request**
   - Reference the issue number
   - Follow existing formatting
   - Include examples if adding features
   - Update version history if changing spec

3. **Engage in Discussion**
   - Respond to review comments
   - Iterate based on feedback
   - Be open to suggestions

## Specification Principles

When contributing, keep these principles in mind:

1. **Simplicity**: Prefer simple solutions over complex ones
2. **Clarity**: Specifications should be unambiguous
3. **Compatibility**: Maintain backward compatibility when possible
4. **Universality**: Keep it tool-agnostic
5. **Practicality**: Specs should be implementable

## What Makes a Good Contribution

###  Good Contributions

- Clarifies ambiguous requirements
- Adds missing examples
- Fixes inconsistencies
- Improves readability
- Shares real-world use cases

###  Avoid

- Adding complexity without clear benefit
- Tool-specific requirements
- Breaking changes without migration path
- Vague or ambiguous language
- Over-engineering

## Spec Changes vs Implementation

**Remember**: ABDS is a specification, not an implementation.

- **Spec changes** → This repository (abds-spec/abds)
- **Tool implementations** → Separate repositories

If you're building tools, create a separate repo and link it here!

## Style Guide

### File Format

- Markdown for documentation
- YAML for frontmatter
- Bash for example scripts

### Language

- Use MUST/SHOULD/MAY (RFC 2119 style)
- Be precise and unambiguous
- Use examples liberally
- Write for both humans and LLMs

### Examples

```markdown
#  Good
Projects MUST have a PROJECT-STATE.md file.

#  Vague
Projects should probably have some kind of state file.
```

## Version History

When making changes:

1. Update the version history section
2. Note the change with date
3. Explain the reasoning
4. Document migration path if breaking

## License

By contributing, you agree that your contributions will be licensed under CC0 1.0 Universal (Public Domain).

## Questions?

Not sure if your contribution is appropriate? Open an issue and ask!

We'd rather discuss early than reject later.

---

**Thank you for helping make ABDS better!**
