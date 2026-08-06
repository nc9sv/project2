FROM python:3.12-slim

WORKDIR /app

COPY backend/requirements.txt ./Expense_Tracker/backend/

COPY frontend /app/Expense_Tracker/frontend

RUN pip install --no-cache-dir -r Expense_Tracker/backend/requirements.txt

COPY backend /app/Expense_Tracker/backend

ENV PYTHONPATH=/app

WORKDIR /app/Expense_Tracker/backend

EXPOSE 5000

CMD ["flask", "--app", "server", "run", "--host=0.0.0.0", "--port=5000"]
