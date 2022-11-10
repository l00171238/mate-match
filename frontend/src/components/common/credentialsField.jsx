export const CredentialsField = ({ label, value, setValue }) => <>
    <div className="form-group mb-3 d-flex align-items-center justify-content-center mb-3">
        <label htmlFor="value" className="me-2">{ label }</label>
        <input type="text"
            name="value"
            id="value"
            className=""
            value={value}
            onChange={event => setValue(event.target.value)} />
    </div>
</>;