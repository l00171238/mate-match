import { useAxiosPrivate } from "../../../hooks";

export default function AvatarUpload({ username, photoID, setProfile }) {
  const axiosPrivate = useAxiosPrivate();

  const uploadAvatar = async (event) => {
    event.preventDefault();

    const formData = new FormData();
    formData.append("image", event.target.files[0]);
    const photo = await axiosPrivate.post(
      `/avatar?email=${username}&photoID=${photoID}`,
      formData,
      {
        headers: { "Content-Type": "multipart/form-data" },
      }
    );
    setProfile(photo.data[0]);
  };

  return (
    <div>
      <label htmlFor="avatar" className="btn btn-success">
        Change Avatar
      </label>
      <div className="input-group">
        <input
          id="avatar"
          onChange={(e) => uploadAvatar(e)}
          type="file"
          accept="image/*"
          className="form-control d-none"
        ></input>
      </div>
    </div>
  );
}
