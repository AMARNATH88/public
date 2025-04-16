import requests, pandas as pd, smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# Fetch & process
data = requests.get("https://your-url-here.com").json()
fmt = lambda x: "N/A" if x is None else f"{x/1e6:.1f} million" if x>=1e6 else f"{x/1e3:.1f} thousand" if x>=1e3 else str(x)
rows = [{"ID": v["id"], "Row Count": fmt(v.get("rowCount", {}).get("public", {}).get("visible"))} for v in data.get("versions", [])]
html = pd.DataFrame(rows).to_html(index=False)

# Email
msg = MIMEMultipart("alternative")
msg["Subject"] = "Version Data"; msg["From"] = "your_email@example.com"; msg["To"] = "recipient@example.com"
msg.attach(MIMEText(f"<p>Hi,<br>Here is the data:</p>{html}", "html"))

with smtplib.SMTP("smtp.yourcompany.com", 587) as s:
    s.starttls(); s.login("your_email@example.com", "your_password")
    s.sendmail(msg["From"], [msg["To"]], msg.as_string())