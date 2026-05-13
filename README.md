# COMP-420 Group Project

By: Hayden Fish, David Smith, Julian Ortiz, Atrin Molanorouzi

## About

### Table Structure
The structure of our tables is slightly complex, in order to account for the repair and product tables.  Our database represents a chain of in-person computer stores, with repair services.

When an order is generated, it consists of a sequence of lines (order_items), which are associated with either products or jobs (repairs) depending on the `order_item_type` field.  For example, if we have a `product` type, then the job field would be **NULL**, and the product field would point towards that product.  The reverse is true in the case that we have a `job` type.

## Contributions Guide

### Using Git

1. Clone the repository with

```
git clone https://github.com/hfish063/COMP-420-Group-Project.git
```

(Ensure git is installed before running this command)

2. Create your feature branch with

```
git branch feature/<NAME OF FEATURE>
```

(and check it out)

```
git checkout feature/<NAME OF FEATURE>
```

This should correspond to the current task you're working on.

3. When you're finished working on your feature, push it to the remote repository

```
git push origin feature/<NAME OF FEATURE>
```

**Tip**: it's helpful to run `git status` frequently, to double check what branch you're currently working on and verify changes.

### Precautions

- Ensure that you run `git pull origin dev` before and after adding contributions to your feature branch, to ensure that you stay up to date with latest changes.
- Resolve merge conflicts if they arise
- Separate tasks into different `.sql` files
- When finished with a feature, push the changes to the remote repository, then create a `pull request` and merge changes into `dev` branch.
