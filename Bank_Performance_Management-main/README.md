# Branch Performance KPIs Dashboard

Two deliverables are included:

- **React web dashboard** (canvas component): interactive charts for deposits vs loans, NPA% vs profitability, CASA vs LDR, and a profitability ranking.
- **Excel dashboard**: `Branch_Dashboard_Excel.xlsx` with a Dashboard sheet, pre-linked charts, and a Data sheet for quick edits. A PDF snapshot `Branch_KPI_Dashboard.pdf` is provided for sharing.

---

## Features
- Clean, professional UI (slate/indigo palette) with value formatting (₹ and %)
- Branch comparisons: Deposits vs Loans; CASA% vs LDR%
- Risk vs returns view: **NPA %** alongside **Profitability** (symmetric secondary axis)
- Lightweight: pure React + Recharts in the web version; native Excel charts in the workbook

---

## Data Model
The sample dataset models each branch as:

| Field | Type | Web (React) units | Excel units |
|---|---|---|---|
| `branch_name` | string | — | — |
| `total_deposits` | number (₹) | absolute | absolute |
| `total_loans` | number (₹) | absolute | absolute |
| `npa_percent` / `npa_ratio` | number | **percent 0–100** | **ratio 0–1** |
| `profitability_index` | number (₹) | absolute (can be negative) | absolute (can be negative) |
| `casa_ratio` | number | **percent 0–100** | **ratio 0–1** |
| `loan_deposit_ratio` | number | **percent 0–100** | **ratio 0–1** |

> Note: The React component uses `npa_percent`, `casa_ratio`, `loan_deposit_ratio` as 0–100 values. The Excel file uses decimal ratios (0–1). Convert accordingly when moving data between them.

---

## Quick Start (Web)
1. Ensure Node.js ≥ 18.
2. Create a React project (Vite example):
   ```bash
   npm create vite@latest kpi-dashboard -- --template react-ts
   cd kpi-dashboard
   npm i recharts lucide-react
   ```
3. Add Tailwind (if you want identical styling):
   - Install and init Tailwind CSS and PostCSS.
   - Include Tailwind directives in your global CSS (`@tailwind base; @tailwind components; @tailwind utilities;`).
4. Create `BranchPerformanceDashboard.tsx` and paste the component from the canvas.
5. Import and render it in your app root.

**Update data:** Edit the `branches` array at the top of the component.

---

## Excel Dashboard
- Open **`Branch_Dashboard_Excel.xlsx`**.
- Go to the **Data** sheet and replace values. Keep columns:
  - `branch_name`, `total_deposits`, `total_loans`, `npa_ratio` (0–1), `profitability_index`, `casa_ratio` (0–1), `loan_deposit_ratio` (0–1).
- Charts on **Dashboard** update automatically.
- Export snapshot: File → Export → PDF (**`Branch_KPI_Dashboard.pdf`**).

### KPI Definitions
- **CASA Ratio** = (Savings + Current) / Total Deposits
- **Loan–Deposit Ratio (LDR)** = Total Loans / Total Deposits
- **NPA %** ≈ Overdue/Defaulted Loan Principal ÷ Total Loan Principal
- **Profitability Index** here is a simple branch-level profit value (₹, can be negative) used for visual ranking.

---

## File Map
- `BranchPerformanceDashboard.tsx` — React component (in canvas)
- `Branch_Dashboard_Excel.xlsx` — Excel dashboard
- `Branch_KPI_Dashboard.pdf` — PDF snapshot

---

## Customization
- Colors: adjust the `PALETTE` object in the React component.
- Labels/formatting: edit `currency()` and percentage formatters in React, and number formats in Excel chart axes.
- Add filters (web): introduce branch/region dropdowns and filter the `branches` array before charting.

---

## Troubleshooting
- Web chart values look off: confirm percent vs ratio units per the table above.
- Profit bars look imbalanced: ensure the profit axis is symmetric around zero (already handled in the component and Excel).
- Excel charts not updating: verify you edited the **Data** sheet headers without renaming/removing columns.

---

## License
Use internally for your portfolio/demo. No external license implied.
