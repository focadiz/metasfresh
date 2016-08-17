package de.metas.ui.web.window.descriptor;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.google.common.base.MoreObjects;
import com.google.common.collect.ImmutableList;

/*
 * #%L
 * metasfresh-webui-api
 * %%
 * Copyright (C) 2016 metas GmbH
 * %%
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program.  If not, see
 * <http://www.gnu.org/licenses/gpl-2.0.html>.
 * #L%
 */

@SuppressWarnings("serial")
public final class DocumentLayoutElementGroupDescriptor implements Serializable
{
	public static final Builder builder()
	{
		return new Builder();
	}

	/** Element group type (primary aka bordered, transparent etc) */
	private final LayoutType layoutType;

	private final List<DocumentLayoutElementLineDescriptor> elementLines;

	private DocumentLayoutElementGroupDescriptor(final Builder builder)
	{
		super();
		layoutType = builder.layoutType;
		elementLines = ImmutableList.copyOf(builder.elementLines);
	}

	@Override
	public String toString()
	{
		return MoreObjects.toStringHelper(this)
				.omitNullValues()
				.add("type", layoutType)
				.add("elements", elementLines.isEmpty() ? null : elementLines)
				.toString();
	}

	public LayoutType getLayoutType()
	{
		return layoutType;
	}

	public List<DocumentLayoutElementLineDescriptor> getElementLines()
	{
		return elementLines;
	}
	
	public boolean isEmpty()
	{
		return elementLines.isEmpty();
	}

	public static final class Builder
	{
		private LayoutType layoutType;
		private final List<DocumentLayoutElementLineDescriptor> elementLines = new ArrayList<>();

		private Builder()
		{
			super();
		}

		public DocumentLayoutElementGroupDescriptor build()
		{
			return new DocumentLayoutElementGroupDescriptor(this);
		}

		public Builder setLayoutType(final LayoutType layoutType)
		{
			this.layoutType = layoutType;
			return this;
		}

		public Builder setLayoutType(final String layoutTypeStr)
		{
			layoutType = LayoutType.fromNullable(layoutTypeStr);
			return this;
		}
		
		public LayoutType getLayoutType()
		{
			return layoutType;
		}

		public Builder addElementLine(final DocumentLayoutElementLineDescriptor elementLine)
		{
			elementLines.add(elementLine);
			return this;
		}
	}
}
