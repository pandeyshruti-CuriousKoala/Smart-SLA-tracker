# Smart Case Routing & SLA Tracker — Weekend Salesforce Project

> Automatically route Cases to correct queues based on Type & Priority — and track SLA breaches with escalation logic


## 🔥 Overview

This project is part of my **Salesforce Weekend Project Series** — where I build real-world Salesforce solutions to simulate actual client scenarios.

In this project, I built a **Smart Case Routing & SLA Tracker** using Apex, Triggers, Flows and Custom Metadata.


##  Features

###  Case Auto-Routing  
Automatically assign incoming Cases to the correct **User** based on:
- **Case Type** (e.g., Technical, Billing, General)
- **Priority** (High, Medium, Low)

✅ Handled via Apex Trigger & Custom Metadata.


### ⏰ SLA Tracking & Violation  
Each Case is assigned a **SLA Deadline** based on its Priority:
- **High** → 4 hours  
- **Medium** → 8 hours  
- **Low** → 24 hours  

A **Scheduled Flow** checks all open Cases every hour.  
If the current time > SLA deadline, it:
- Marks `SLA_Violated__c = true`
- Changes the status to **Escalated**.
- Triggers an **Email Alert** to notify the Case Owner via Email


## 💡 Why This Project?

This is a **real-world scenario** in Service Cloud orgs:
- Automating Case assignment
- Tracking SLAs & escalations
- Using Apex + Declarative tools together

🔍 Interview-Ready Skills Covered:
- Custom Metadata + Apex + Triggers  
- Scheduled Flows  
- Escalation Rules  
- Workflow Rule with Email Template


## 🛠️ Tech Stack

| Layer | Tool Used |
|-------|-----------|
| Backend Logic | Apex Trigger & Handler |
| Config | Custom Metadata Types |
| SLA Management | Workflow Rule |
| Notification | Workflow Email |
| Deployment | SFDX, Git, VS Code |


## 🚀 Setup Instructions

### 1. Clone the repo
```bash
git clone https://github.com/your-username/smart-case-routing-sla.git
````

### 2. Authorize your Salesforce Org

```bash
sfdx force:auth:web:login -a CaseSLAOrg
```

### 3. Deploy the source

```bash
sfdx force:source:deploy -p force-app
```

### 4. Create Custom Metadata Records

Go to `Case_Routing_Rule__mdt` and add rules like:

| Case Type |  User |
| --------- |  ----------------- |
| Technical |  UserID |
| Billing | UserID |
| General | UserID |


Go to `Case_SLA_Rule__mdt` and add rules like:

| Case Type | Priority |
| --------- | -------- | 
| Technical | High | 
| Billing | Medium | 
| General | Low |

### 5. Configure Email Template

* Go to **Email Templates**
* Create a Template for SLA Breach Notification

### 6. Setup Workflow Flow

* A Workflow runs and checks open cases
* If SLA Deadline crossed → sets `SLA_Violated__c = true`
* Sets status to `Escalated`
* Sends email to Case Owner using the template above

### 7. Error configuration
* Added erros for every invalid behaviour using triggers.


## 👩‍💻 About Me

I’m **Shruti Pandey**, Salesforce Developer at Deloitte with nearly 2 years of experience.

🌐 I build these projects to:

* Deepen my hands-on expertise
* Help others learn from practical builds
* Showcase my ability to build scalable Salesforce logic

💼 Connect on [LinkedIn](https://www.linkedin.com/in/shruti-pandey16)
📁 More projects on [GitHub](https://github.com/pandeyshruti-CuriousKoala?tab=repositories)


## ⭐ Star this repo if it helped you learn something new!
